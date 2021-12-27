# convert password
import sys
from notebook.auth import passwd
my_password = sys.argv[1]
hashed_password = passwd(passphrase=my_password, algorithm='sha256')
print(hashed_password)
