import discid
import pymysql
import getpass

db = pymysql.connect(host="localhost", user="will", passwd="Bamboo123", db="CD_Database", autocommit=True)
cur = db.cursor()

disc = discid.read("/dev/cdrom",features=["mcn"])
mcn = disc.mcn
if mcn == "":
	print ("DISC UPC NOT FOUND. MANUALLY ENTER")
else:
	print ("DISC UPC: %s" % mcn)

user = getpass.getuser()

sql = "INSERT INTO WeHave(UPC,AddedBy) VALUES ('" + str(mcn) + "','" + str(user) + "');"
cur.execute(sql)

