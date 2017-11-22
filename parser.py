from lxml import html
import requests
import csv

page = requests.get('http://wilbur.simons-rock.edu/cg/Spring2018CourseGuide.php')

tree = html.fromstring(page.content)

classes = tree.xpath('//td/text()')

course_status = tree.xpath('//i/text()')

course_name = tree.xpath('//a/text()')

description_name = tree.xpath('//b/text()')


def cleaning_classes_lst(classes):
	new_l = []
		
	for i in range(len(classes)):
		s = str(classes[i])
		new_s = s.replace("\n", "")
		if new_s != '' and new_s != ' ' and new_s != '  ' and new_s != '\xa0' and new_s != 'All Offerings' and new_s != 'Books' and new_s != '   ':
			new_l.append(new_s)

	return new_l


new_l = cleaning_classes_lst(classes)
	
ncourse_status = []
for i in course_status:
	if i != "Top" and i != "Home" and i != '' and i!= '  ' and i != '   ':
		ncourse_status.append(i)


new_l = new_l[3:]  # multiples of by 8

course_name = course_name[49:]

nlink = []
for i in course_name:
	
	if "Lab" == i[(len(i)-3):(len(i))]:
		nlink.append([i,"lab credit"])
	
	elif i != "Books" and i != '' and i != '  ' and i != '   ':
		nlink.append(i)


final_lst = []

add_lab_b = False
add_lab = 0
switch = 8

for i in range(len(new_l)):
	if new_l[i] != "   " and '---' not in new_l[i]:
		final_lst.append(new_l[i])
	
	if i % switch  == 0:
		
		if(i == 0):
			final_lst.append(ncourse_status[0])
			final_lst.append(nlink[0])
		else:
			try:
				if add_lab_b == True:
					# add_lab_b = False

					last = final_lst[len(final_lst)-(add_lab):len(final_lst)]
					
					final_lst = final_lst[:len(final_lst)-(add_lab)]

					# print(last, add_lab, len(final_lst)-(add_lab), len(final_lst))


					final_lst.append(ncourse_status[int(i//8)])
					

					if type(nlink[int(i//8)]) == list:
						final_lst.append(nlink[int(i//8)][0])
						final_lst.append(nlink[int(i//8)][1])
						add_lab_b = True
						add_lab += 1

					else:
						final_lst.append(nlink[int(i//8)])
					
					
					final_lst += last

				
				else:
					final_lst.append(ncourse_status[int(i//8)])
					if type(nlink[int(i//8)]) == list:
						final_lst.append(nlink[int(i//8)][0])
						final_lst.append(nlink[int(i//8)][1])
						add_lab_b = True
						add_lab += 1

					else:
						final_lst.append(nlink[int(i//8)])
									
			except:
				break


final_lst = final_lst[:final_lst.index("Courses appropriate for First Year students without special preparation")]


course_data = []
temp_lst = []

for i in range(len(final_lst)):
	if i%10 == 0 and i !=0:
		course_data.append(temp_lst)
		temp_lst = []
		temp_lst.append(final_lst[i])

	else:
		temp_lst.append(final_lst[i])



description = []
for i in new_l:
	description.append(i)


def find_descriptions(description):
	for i in range(len(description)):
		if(len(description[len(description)-(i+1)]) == 1):
			x = len(description) - i
			return x
x = find_descriptions(description)

unfinished = description[x:]

description = []
temp = []
for i in unfinished:
	if "---" not in i:
		temp.append(i)
	else:
		description.append(temp)
		temp = []


description_name = description_name[description_name.index("Course Descriptions")+1:]
for i in course_data:
	if " "+i[2] in description_name:
		i += (description[description_name.index(" "+i[2])])
	else:
		i += ["No Description Found"]

course_data_repeats = course_data
course_data = []
[course_data.append(item) for item in course_data_repeats if item not in course_data]

print(len(course_data[0]))

with open('course_guide_data.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',',quoting=csv.QUOTE_ALL)
    for course in course_data:
   		writer.writerow(i.replace("'", '"') for i in course)

csvfile.close()