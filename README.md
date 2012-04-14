NOTES:

Setup(all these are supposed to be executed locally(in your chef-client) by the way):

* clone repo: `git clone git@github.com:devpopol/dev.git`
* download(to .chef) the organization key and user keys from opscode: (devpopol.pem and precise-validator.pem). ref: http://wiki.opscode.com/display/chef/Fast+Start+Guide#FastStartGuide-Step5%253AConfiguretheworkstationasaclient (under Step 5: Configure the workstation as a client)
* upload all stuff: 
  - `knife bootstrap $(./dev_env) -d centos6` #bootstrap the remote machine
  - `rake setup_after_bootstrap` #setup everything
