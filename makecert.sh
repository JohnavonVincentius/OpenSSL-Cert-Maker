echo Cert Name : 
read Certname

echo Key Name :
read Keyname

echo RSA Size :
read RSA

echo Certificate Validity : 
read Time

echo IP Address :
read ip

echo Country ID :
read Country

echo Province :
read Prov

echo State :
read State

echo Organisation Name : 
read Organame

echo Common Name :
read ComName

echo Email Address : 
read EmailAddr

cat> san.conf <<EOF
[req]
default_bits  = $RSA
distinguished_name = req_distinguished_name
req_extensions = req_ext
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
countryName = $Country
stateOrProvinceName = $Prov
localityName = $State
organizationName = $Organame
commonName = $ComName
emailAddress = $EmailAddr

[req_ext]
subjectAltName = @alt_names

[v3_req]
subjectAltName = @alt_names

[alt_names]
IP.1 = $ip
EOF

openssl req -x509 -nodes -days $Time -newkey rsa:$RSA -keyout $Keyname -out $Certname -config san.conf
mkdir logs
cp san.conf logs/
rm san.conf