from flask import Flask, render_template, request, redirect, url_for, session
from datetime import datetime
import base64
# from flask_session import Session
import pymysql
import hashlib
import binascii
import json
from functools import wraps
salt = "cpe334"

app = Flask(__name__)
conn = pymysql.connect(
    host='localhost',
    user='root',
    password='',
    db='stock'
)
cur = conn.cursor()
app.secret_key = "super secret key"

# function login
@app.route("/login", methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        dataBase_password = password + salt
        hashed = hashlib.md5(dataBase_password.encode())
        
        cur.execute("SELECT * FROM User_List WHERE Username = %s AND Password = %s",
                    (username, hashed.hexdigest()))
        
        record = cur.fetchone()
        if record:
            session['loggedin'] = True
            session['username'] = record[1]
            return redirect(url_for('dashboard'))
        else:
            msg = "Incorrect"
        
        conn.commit()
    return render_template('User_login.html', msg=msg)

# status is login
def islogin(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'loggedin' not in session or not session['loggedin']:
            return redirect(url_for('login'))
        return f(*args, **kwargs)

    return decorated_function


@app.route("/")
def home():
    conn.ping(reconnect=True)
    return redirect(url_for('dashboard'))

# function logout
@app.route("/logout")
def logout():
    session.pop('loggedin', None)
    session.pop('username', None)
    return redirect(url_for('home'))


# dashboard
@app.route("/dashboard")
@islogin
def dashboard():
    cur.execute("SELECT role.Role_Name FROM user_list JOIN role ON user_list.Role_ID = role.Role_ID WHERE user_list.Username = %s", (session['username']))
    rows = cur.fetchone()
    return render_template('Dashboard.html',Username = session['username'],Position = rows[0])

@app.route("/orders")
@islogin
def orders():
    return render_template('Orders.html')

@app.route("/product")
@islogin
def product():
    return render_template('Product.html')

@app.route("/stock_report")
@islogin
def stock_report():
    return render_template('Stockreport.html')

@app.route("/staff")
@islogin
def staff():
    return render_template('Staff.html')

# profile
@app.route("/staff/profile")
@islogin
def profile():
    cur.execute("SELECT * FROM user_list WHERE Username = %s", (session['username']))
    rows = cur.fetchall()
    Firstname = rows[0][3]
    Surname = rows[0][4]
    Email = rows[0][5]
    Address = rows[0][6]
    Phone = rows[0][7]
    return render_template('Profile.html',Username = session['username'],Firstname=Firstname,Surname = Surname,Email=Email,Address=Address,Phone=Phone)

# @app.route("/staff/edit-profile")
# @islogin
# def editprofile():
#     cur.execute("SELECT * FROM user_list WHERE Username = %s", (session['username']))
#     rows = cur.fetchall()
#     return render_template('profileedit.html', data = rows)

@app.route("/staff/update_profile", methods=['POST'])
@islogin
def update_profile():
    if request.method == "POST":
        Firstname = request.form['Firstname']
        Surname = request.form['Surname']
        Email = request.form['Email']
        Address = request.form['Address']
        Phone = request.form['Phone']
        Password = request.form['NewPassword']
        if Password :
            dataBase_password = Password + salt
            hashed = hashlib.md5(dataBase_password.encode())

            sql = "UPDATE user_list SET Firstname = %s, Surname = %s, Email = %s, Address = %s, Phone = %s ,Password = %s WHERE Username = %s"
            cur.execute(sql, (Firstname, Surname, Email,Address,Phone,hashed.hexdigest(),session['username']))
        else :
            sql = "UPDATE user_list SET Firstname = %s, Surname = %s, Email = %s, Address = %s, Phone = %s WHERE Username = %s"
            cur.execute(sql, (Firstname, Surname, Email, Address, Phone, session['username']))

        conn.commit()

        return redirect(url_for('home'))



def check_manager():
    cur.execute("SELECT Role_ID FROM user_list WHERE Username = %s ",
                (session['username'],))
    check_manager = cur.fetchone()
    return check_manager[0]




if __name__ == '__main__':
       app.run(debug=True)



    
