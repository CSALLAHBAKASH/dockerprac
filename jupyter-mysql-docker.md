You can achieve your goal by using Docker to run separate containers for Jupyter Notebook and MySQL, and then connecting them. Here's a step-by-step guide:

1. **Install Docker**: Make sure you have Docker installed on your system.

2. **Create a Docker Network**: Create a Docker network to allow the containers to communicate. This step is optional, but it's a good practice to isolate your containers on a network.

   ```bash
   docker network create mynetwork
   ```

3. **Run the MySQL Container**:
   Run a MySQL container with a specific network and environment variables (replace `[password]` and `[database]` with your desired values):

   ```bash
   docker run --network mynetwork --name mysql-container -e MYSQL_ROOT_PASSWORD=[password] -e MYSQL_DATABASE=[database] -d mysql:latest
   ```

   This command creates a MySQL container named `mysql-container` and sets up the root password and a specific database.

4. **Run the Jupyter Notebook Container**:
   Run a Jupyter Notebook container with a specific network, and link it to the MySQL container:

   ```bash
   docker run --network mynetwork -p 8888:8888 --name jupyter-container -v /path/to/your/notebooks:/home/jovyan/notebooks jupyter/base-notebook
   ```

   Replace `/path/to/your/notebooks` with the path to your Jupyter Notebook files.

5. **Access Jupyter Notebook**:
   In your terminal, you will see a URL with a token that allows you to access your Jupyter Notebook. Copy and paste this URL into your web browser.

6. **Connect Jupyter Notebook to MySQL**:
   You can connect to the MySQL database from within your Jupyter Notebook using Python libraries like `mysql-connector-python` or `SQLAlchemy`. Here's an example using `mysql-connector-python`:

   ```python
   import mysql.connector

   # Define connection parameters
   config = {
       'user': 'root',
       'password': '[password]',
       'host': 'mysql-container',  # Use the container name as the host
       'database': '[database]'
   }

   # Create a connection
   connection = mysql.connector.connect(**config)

   # Now you can perform database operations using 'connection'
   ```

   Replace `[password]` and `[database]` with the values you provided when starting the MySQL container.

Now, you have a Jupyter Notebook running in one container and a MySQL database running in another container, both connected through the Docker network. You can use Python code in your Jupyter Notebook to interact with the MySQL database as needed.