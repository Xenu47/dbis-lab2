# Сторожук Антон, КМ-83, Лабораторна робота 2
## Інструкція по запуску
1. Завантажити репозиторій
2. Додати в локальну папку репозиторію Odata2019File.csv та Odata2020File.csv (завантажені і розархівовані із https://zno.testportal.com.ua/opendata)
3. Запустити lab1.py
4. Завантажити flyway (https://flywaydb.org/documentation/usage/commandline/#download-and-installation)
5. Розархівувати дані з в папку з завантаженим репозиторієм, **щоб локальна папка sql об'єдналась з папкою із архіву**
6. У файлі config/flyway.conf внести дані для підключення до своєї бази даних у рядках: 
    * 43 - flyway.url=jdbc:postgresql://localhost:5432/postgres (або своє, якщо postgresql настроєно нестандартно)
    * 50 - flyway.user=\_\_\_\_\_ (свій логін)
    * 54 - flyway.password=\_\_\_\_\_ (свій пароль)
7. Запустити командний рядок у головній папці
8. Викликати команду **flyway baseline**
9. Викликати команду **flyway migrate**

## Результати виконання запиту
![Результати виконання запиту](https://user-images.githubusercontent.com/44733274/113494908-9903e600-94f5-11eb-881b-ac0911f1fbdc.png)

## Логічна діаграма
![Логічна діаграма](https://user-images.githubusercontent.com/44733274/113494718-b3d55b00-94f3-11eb-95b9-6cd90bc5cfab.png)

## Фізична діаграма
![Фізична діаграма](https://user-images.githubusercontent.com/44733274/113494702-6d7ffc00-94f3-11eb-8753-0e0780fc5c36.png)
