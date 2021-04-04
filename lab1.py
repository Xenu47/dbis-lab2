import time
import psycopg2
import csv
import os
import re
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(
	filename='lab1.log', 
	level=logging.INFO, 
	format='%(asctime)s - %(message)s'
)

conn = psycopg2.connect("dbname=postgres user=postgres password=qwe123")
cursor = conn.cursor()

def is_num(var):
	var_temp = var.replace(',', '.')
	pattern = r"^-?\d+(\.\d+)?$"
	if re.match(pattern, var_temp):
		return True
	else:
		return False

def make_log(message, _time=time.time()):
	status = (message)
	logger.info(status)
	print(time.ctime(_time) + ' - ' + status)



def create_table(file, table='zno_opendata'):
	with open(file, 'r', encoding='cp1251') as csvfile:
		header = csvfile.readline().rstrip('\n').split(';')
		for word in header:
			i = header.index(word)
			word = word.strip('"')
			header[i] = word
		
	with open(file, 'r', encoding='cp1251') as csvfile:
		csv_reader = csv.DictReader(csvfile, delimiter=';')
		for row in csv_reader:
			example_data = list(row.values())
			break

		while 'null' in example_data:
			i = []
			for e in range(len(example_data)):
				if example_data[e] == 'null':
					i.append(e)
			for row in csv_reader:
				temp_data = list(row.values())
				break
			for e in range(len(temp_data)):
				if e in i and temp_data[e] != 'null':
					example_data[e] = temp_data[e]

		query = f'''CREATE TABLE IF NOT EXISTS {table} (
	year INT,'''
		numeric_cols = []
		for word in header:
			i = header.index(word)
			if word == 'OUTID':
				query += '\n\t' + word + ' VARCHAR(255) PRIMARY KEY,'
			elif is_num(example_data[i]):
				query += '\n\t' + word + ' NUMERIC,'
			else:
				query += '\n\t' + word + ' VARCHAR(255),'
		query = query.rstrip(',')
		query += '\n);'

		cursor.execute(query)
		conn.commit()
		make_log(f'CREATED: table {table} from {file}')

		return header, example_data



def populate_table(file, table='zno_opendata', cursor=cursor, conn=conn):
	start_time = time.time()

	with open(file, 'r', encoding='cp1251') as csvfile:
		make_log(f'POPULATE START: file {file}', start_time)
		csv_reader = csv.DictReader(csvfile, delimiter=';')
		batch_size = 50
		batches = 0
		finished = False

		while not finished:
			try:
				year = int(file[5:9])
				query = f'INSERT INTO {table} (year, ' + ', '.join(header) + ') VALUES '
				n = 0
				for row in csv_reader:
					n += 1
					for key in row:
						if row[key] == 'null':
							pass
						elif is_num(row[key]):
							row[key] = row[key].replace(',', '.')
						elif row[key]:
							row[key] = "'" + row[key].replace("'", "") + "'"
					query += '\n\t(' + str(year) + ', ' + ', '.join(row.values()) + '),'

					if n == batch_size:
						n = 0
						query = query.rstrip(',') + ';'
						try:
							cursor.execute(query)
							conn.commit()
						except:
							pass
						batches += 1
						query = f'INSERT INTO {table} (year, ' + ', '.join(header) + ') VALUES '
					
				if n != 0:
					query = query.rstrip(',') + ';'
					try:
						cursor.execute(query)
						conn.commit()
					except:
						pass
					finished = True

			except psycopg2.OperationalError as e:
				if e.pgcode == psycopg2.errorcodes.ADMIN_SHUTDOWN:
					make_log(f'DISCONNECTED: on {file}')
					reconnected = False

					while not reconnected:
						try:
							conn = psycopg2.connect(dbname='postgres', user='postgres', password='qwe123')
							cursor = conn.cursor()
							make_log(f'ATTEMPT: reconnect on {file}')
							reconnected = True
						except psycopg2.OperationalError as e:
							pass

					make_log(f'RECONNECTED: on {file}')
					csvfile.seek(0,0)
					csv_reader = itertools.islice(csv.DictReader(csv_file, delimiter=';'), batches * batch_size, None)

	end_time = time.time()
	make_log(f'POPULATE FINISHED: file {file}', end_time)
	make_log(f'TOTAL TIME SPENT ON {file}: {end_time-start_time:.4f} seconds')

	return cursor, conn



def select_table(mark_type, subject, table='zno_opendata'):
	try:
		query = f'''
	SELECT regname, year, {mark_type}({subject}Ball100)
	FROM {table}
	WHERE {subject}TestStatus = 'Зараховано'
	GROUP BY regname, year;
		'''
		cursor.execute(query)

		with open(f'{mark_type}-{subject}.csv', 'w', encoding="utf-8") as result_csvfile:
			csv_writer = csv.writer(result_csvfile)
			csv_writer.writerow(['Область', 'Рік', 'Середній бал з Історії України'])
			for row in cursor:
				csv_writer.writerow(row)
			make_log(f'SELECTED: {mark_type} mark from {subject}')
	except Exception as e:
		if type(e) == psycopg2.errors.UndefinedTable:
			make_log(f'ERROR: select before create')
		else:
			print(e, type(e))



def drop_table(table='zno_opendata', cursor=cursor, conn=conn):
	cursor.execute(f'DROP TABLE IF EXISTS {table}')
	conn.commit()
	make_log(f'DROP: table {table} IF EXISTS')

	return cursor, conn



cursor, conn = drop_table('zno_opendata')

header, example_data = create_table('Odata2019File.csv')

cursor, conn = populate_table('Odata2019File.csv')
cursor, conn = populate_table('Odata2020File.csv')

select_table('avg', 'hist')


cursor.close()
conn.close()