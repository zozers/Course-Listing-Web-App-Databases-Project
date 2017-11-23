
# example input to function below
stringThing = "MWF 10:05-11:00 AM in CL1-04 and TR 10:35-12:00 PM in CL3-13"

def split_multis(multivalue):
	""" returns list will multi times """
	return multivalue.split(" and ")


# example input to function below
stringThing = "MWF 10:05-11:00 AM in CL1-04"
stringThing2 = "TR 10:35-12:00 PM in CL3-13"

def split_times(value):
	""" takes in value from course_guide_cleaned.csv column E and returns separated value, treating all information as separate """

	# note: AM / PM based on END TIME


	# get rid of dash between times
	value = value.replace("-", " ")
	# get rid of word 'in'
	value = value.replace("in", " ")
	# split on spaces
	split_val = value.split(" ")
	# remove resulting empty strings
	temp = []
	for i in split_val:
		if len(i) != 0:
			temp.append(i)
	split_val = temp[:]

	# split_val status: [days 0, time begin 1, time end 2, am/pm 3, building 4, room 5]

	# first, create instance for each day
	new_vectors = []
	for i in range(len(split_val[0])):
		# for each day
		temp_day = split_val[0][0][i]

		# need to decide am / pm for time begin (we only know value for end time)
		# want all times in format: "00:00:00"

		vect_beg = split_val[0][1].split(":")
		vect_end = split_val[0][2].split(":")



	print(split_val)

split_times(stringThing)
