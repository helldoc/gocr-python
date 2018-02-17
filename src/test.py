import gocr_py
import io

file = open("/home/user/work/test/test2.pnm", "rb")
readed = file.read()
array = bytearray(readed)
res = gocr_py.process_image(array)
print (res)

