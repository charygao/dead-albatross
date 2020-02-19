# dead-albatross

Tenable.IO Nessus API example works to help other people who are learning.

The intention is to place guided information and examples here.

I've chosen to use BASH and CURL as the most basic and common tools in light of making this easy for network and system administrators.

I've pulled out the Powershell scripts that I had written.

I'm moving to python scripts albeit slowly.

Requirements:
* Your favourite shell with curl installed
* Your favourite shell with Python installed
* A Nessus account with Tenable.IO
* API Access Key and Secret Key

I use either 'jq' (https://brew.sh) on MacOS or 'jparse' on linux for parsing JSON. Don't forget the new release of jq requires new parameters, eg. 'cat frank.in | jq . > frank.out', ie. The search criteria, in this case a single period.

Ref: https://developer.tenable.com/reference

Ref: https://docs.tenable.com/TenableIO.htm

You're welcome,

Jolyon Ansuz
