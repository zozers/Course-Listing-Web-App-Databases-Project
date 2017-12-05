import os
import psycopg2
import psycopg2.extras
from flask import Flask, request, session, g, redirect, url_for, abort, \
		render_template, flash

app = Flask(__name__) # create the application instance :)
app.config.from_object(__name__) # load config from this file , flaskr.py

# Load default config and override config from an environment variable
app.config.update(dict(
	DATABASE=os.path.join(app.root_path, 'flaskr.db'),
	SECRET_KEY='development key',
	USERNAME='test',
	PASSWORD='test'
))
app.config.from_envvar('FLASKR_SETTINGS', silent=True)

# def connect_db():
# 	"""Connects to the specific database."""
# 	rv = sqlite3.connect(app.config['DATABASE'])
# 	rv.row_factory = sqlite3.Row
# 	return rv

def connect_db():
	"""Connects to the specific database."""
	rv = psycopg2.connect(dbname="course_guide")
	return rv



def init_db():
	db = get_db()
	with app.open_resource('Schema_2.sql', mode='r') as f:
		db.cursor().executescript(f.read())
	db.commit()

	with app.open_resource('complete_data_insert.sql', mode='r') as f:
		db.cursor().executescript(f.read())

	db.commit()

@app.cli.command('initdb')
def initdb_command():
	"""Initializes the database."""
	init_db()
	print('Initialized the database.')


def get_db():
	"""Opens a new database connection if there is none yet for the
	current application context.
	"""
	if not hasattr(g, 'course_guide'):
		g.course_guide = connect_db()
	return g.course_guide


@app.teardown_appcontext

def close_db(error):
	"""Closes the database again at the end of the request."""
	if hasattr(g, 'course_guide'):
		g.course_guide.close()


@app.route('/')
def show_entries():
	db = get_db()
	db = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
	cur = db.execute('select * from course')
	entries = db.fetchall()
	# print("entries is ", entries)
	return render_template('show_entries.html', entries=entries)



@app.route('/add', methods=['POST'])
def add_entry():
	if not session.get('logged_in'):
		abort(401)
	db = get_db()
	cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
	
	if (request.form['title'] == ""):
		flash('New entry cannot have an empty title!!')
		return redirect(url_for('show_entries'))
	if (request.form['text'] == ""):
		flash('New entry cannot have an empty entry!!')
		return redirect(url_for('show_entries'))
	
	cur.execute('insert into entries (title, text) values(%s,%s)',
		(request.form['title'], request.form['text']))

	db.commit()
	# flash(request.form['id'])
	return redirect(url_for('show_entries'))



@app.route('/delete', methods=['POST'])
def delete_entry():
	if not  session.get('logged_in'):
		abort(401)
	db = get_db()
	cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
	# print(request.form['id'])
	
	cur.execute('delete from entries where id = (%s)',(
		request.form['id'],))

	db.commit()
	flash('Entry was successfully deleted')
	return redirect(url_for('show_entries'))



@app.route('/edit')
def edit_entry():
	db = get_db()
	db = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
	cur = db.execute('select title, text, id from entries where id =(%s)',(
		request.args.get('id'),))
	entries = db.fetchall()
	# print("entries is ", entries)
	return render_template('edit.html', entry=entries[0])



@app.route('/update_db', methods=['POST'])
def update_entry():
	if not  session.get('logged_in'):
		abort(401)
	db = get_db()
	cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
	# print(request.form['id'])
	
	cur.execute('update entries set title = (%s), text = (%s) where id = (%s);',(
		request.form['title'], request.form['text'], request.form['id'],))

	db.commit()
	flash('Entry was successfully Updated')
	return redirect(url_for('show_entries'))


@app.route('/login', methods=['GET', 'POST'])
def login():
	error = None
	if request.method == 'POST':
		if request.form['username'] != app.config['USERNAME']:
			error = 'Invalid username'
		elif request.form['password'] != app.config['PASSWORD']:
			error = 'Invalid password'
		else:
			session['logged_in'] = True
			flash('You were logged in')
			return redirect(url_for('show_entries'))
	return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))



if __name__ == '__main__':
    app.run(debug=True)







	