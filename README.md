# TestingStuff
This is a playground for my efforts to code in linux.
from src
valac --pkg mysql --pkg gtk+-3.0 --pkg gmodule-2.0 MySharedLibrary.vapi main.vala -X -L/usr/lib64/mysql -X -lmysqlclient -X mysharedlibrary.so -X -I. -o main
