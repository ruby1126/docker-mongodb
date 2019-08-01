# docker-mongodb
<p>mongodb in docker linux container，並做Replica Set</p>
<p>將所有檔案下載，也在本機上裝docker</p>

### 建立mongodb
打開powershell
<pre><code>docker-compose up -d
</pre></code>
### 建立mongodb Replica Set
<p>打開powershell</p>
<p>[hostname]請置換成你的主機ip!!!!!!!!!!!!!!!!!!!!!!!</p>

<pre><code>docker exec -it mongo1 bash
mongo 
rs.initiate({_id : "rs0",members: [{_id: 0, host: "[hostname]:27007" },{ _id: 1, host: "[hostname]:27008" },{ _id: 2, host: "[hostname]:27009" }]})
</pre></code>

<p>查看狀態</p>

<pre><code>rs.status()</pre></code>

<p>增加使用者</p>

<pre><code>use admin
db.createUser({user:'root',pwd:'password',roles:[{ role: "userAdminAnyDatabase", db: "admin" }]})
exit
exit
</pre></code>

<p>修改mongod.conf</p>

<pre><code>net:
  port: 27017
  bindIpAll: true
  maxIncomingConnections: 1000000
replication:
  replSetName: rs0 
security:
  authorization: enabled                 <<====================================================增加auth
  keyFile: ./keyfile                
</pre></code>

<p>重新啟動，更新mongod.conf</p>

<pre><code>docker-compose restart</pre></code>


### 補充:建立keyfile
打開cmd
<pre><code>"C:\Program Files\Git\mingw64\bin\openssl.exe" rand -base64 741 > c:\keyfile
</pre></code>
