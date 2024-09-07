import struct, os
__64k = 65536
__longlong_format_char = 'q'
__byte_size = struct.calcsize(__longlong_format_char)

def temp_file():
	import tempfile
	file = tempfile.NamedTemporaryFile()
	filename = file.name
	return filename
	
def is_local(_str):
	from urllib.parse import urlparse
	if os.path.exists(_str):
		return True
	elif urlparse(_str).scheme in ['','file']:
		return True
	return False

def hash_size_File_url(filepath): 
	#https://trac.opensubtitles.org/projects/opensubtitles/wiki/HashSourceCodes
	#filehash = filesize + 64bit sum of the first and last 64k of the file
	name = filepath
	if is_local(filepath):
		local_file = True
	else:
		local_file = False

	if local_file == False:
		f = None
		url = name
		import requests

		response = requests.head(url)#, verify=False)
		filesize = int(response.headers['content-length'])

		if filesize < __64k * 2:
			try: filesize = int(str(response.headers['content-range']).split('/')[1])
			except: pass


		first_64kb = temp_file()
		last_64kb = temp_file()

		headers = {"Range": 'bytes=0-%s' % (str(__64k -1 ))}
		r = requests.get(url, headers=headers)#, verify=False)
		with open(first_64kb, 'wb') as f:
			for chunk in r.iter_content(chunk_size=1024): 
				if chunk: # filter out keep-alive new chunks
					f.write(chunk)

		if filesize > 0:
			headers = {"Range": 'bytes=%s-%s' % (filesize - __64k, filesize-1)}
		else:
			f.close()
			os.remove(first_64kb)
			return "SizeError", 0

		try:
			r = requests.get(url, headers=headers)#, verify=False)
			with open(last_64kb, 'wb') as f:
				for chunk in r.iter_content(chunk_size=1024): 
					if chunk: # filter out keep-alive new chunks
						f.write(chunk)
		except:
			f.close()
			if os.path.exists(last_64kb):
				os.remove(last_64kb)
			if os.path.exists(first_64kb):
				os.remove(first_64kb)
			return 'IOError', 0
		f = open(first_64kb, 'rb')

	try:
		longlongformat = '<q'  # little-endian long long
		bytesize = struct.calcsize(longlongformat) 

		if local_file:
			f = open(name, "rb") 
			filesize = os.path.getsize(name) 
		hash = filesize 

		if filesize < __64k * 2: 
			f.close()
			if local_file == False:
				os.remove(last_64kb)
				os.remove(first_64kb)
			return "SizeError", 0

		range_value = __64k / __byte_size
		range_value = round(range_value)

		for x in range(range_value): 
			buffer = f.read(bytesize) 
			(l_value,)= struct.unpack(longlongformat, buffer)  
			hash += l_value 
			hash = hash & 0xFFFFFFFFFFFFFFFF #to remain as 64bit number  

		if local_file:
			f.seek(max(0,filesize-__64k),0) 
		else:
			f.close() 
			f = open(last_64kb, 'rb')
		for x in range(range_value): 
			buffer = f.read(bytesize) 
			(l_value,)= struct.unpack(longlongformat, buffer)  
			hash += l_value 
			hash = hash & 0xFFFFFFFFFFFFFFFF 
		
		f.close() 
		if local_file == False:
			os.remove(last_64kb)
			os.remove(first_64kb)
		returnedhash =  "%016x" % hash 
		return returnedhash, filesize

	except(IOError): 
		if local_file == False:
			os.remove(last_64kb)
			os.remove(first_64kb)
		return 'IOError', 0