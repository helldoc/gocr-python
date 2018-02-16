import gocr_py
import io

res = gocr_py.process_path("/home/user/work/test/test2.pnm")
print (res)
array = bytearray(b'Hello bro HEH')
res = gocr_py.process_image(array)
print (res)

