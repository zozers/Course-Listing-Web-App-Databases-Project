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
    PASSWORD='penis'
))
app.config.from_envvar('FLASKR_SETTINGS', silent=True)


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


@app.route('/courses')
def show_courses():
    db = get_db()
    db = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur = db.execute('select * from course order by course.name')
    courses = db.fetchall()
    return render_template('future_show_entries.html', entries=courses)



# @app.route('/')
# def find_entry():
#   db = get_db()
#   db = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
#   cur = db.execute('select * from course where course.name LIKE "%"" + "(%s)" + "%";',(request.form['search'],))
#   courses = db.fetchall()
#   # print("entries is ", entries) 


#   return render_template('input_search.html', courses=courses[0])





@app.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == "POST":
        db = get_db()
        db = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
        print(request.form['search'])
        cur = db.execute('''select * from course where course.name ILIKE %s''', ('%'+request.form['search']+'%',))
        courses = db.fetchall()

        return render_template("future_show_entries.html", courses=courses)
    
    return render_template('input_search.html')






# @app.route('/update_db', methods=['POST'])
# def update_entry():
#   if not  session.get('logged_in'):
#       abort(401)
#   db = get_db()
#   cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)
#   # print(request.form['id'])
    
#   cur.execute('update entries set title = (%s), text = (%s) where id = (%s);',(
#       request.form['title'], request.form['text'], request.form['id'],))

#   db.commit()
#   flash('Entry was successfully Updated')
#   return redirect('show_sorted.html')



if __name__ == '__main__':
    app.run(debug=True)







    