NOTES:

Setup(all these are supposed to be executed locally(in your chef-client) by the way):

* clone repo: `git clone git@github.com:devpopol/dev.git`
* download(to .chef) the organization key and user keys from opscode: (devpopol.pem and precise-validator.pem). ref: http://wiki.opscode.com/display/chef/Fast+Start+Guide#FastStartGuide-Step5%253AConfiguretheworkstationasaclient (under Step 5: Configure the workstation as a client)
* run bootstrap: knife bootstrap li413-17.members.linode.com -d centos6
* upload all stuff: 
  - `knife cookbook upload -a` #upload all cookbooks
  - `knife role from file roles/*.rb` #create or update all roles
  - `knife data bag create users` and `knife data bag from file users deploy.json` #create the users data bag and upload
  - `rake linode:assign_role` #(assigns li413-17.members.linode.com to have the dev_env role)