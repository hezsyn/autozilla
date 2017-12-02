class AutozillaKeyConfig < ApplicationRecord
  include Azk::Key
  has_many :image

  def czAZKConfig(direction)
    if direction == "upload"
      self.params_set = SupportStuff.find_by(name: "dupParamsSet").value
      self.edd = SupportStuff.find_by(name: "dupEdd").value
      self.prerun0 = SupportStuff.find_by(name: "dupPrerun0").value
      self.prerun1 = SupportStuff.find_by(name: "dupPrerun1").value
      self.prerun2 = SupportStuff.find_by(name: "dupPrerun2").value
      self.prerun3 = SupportStuff.find_by(name: "dupPrerun3").value
      self.prerun4 = SupportStuff.find_by(name: "dupPrerun4").value
      self.live_run = SupportStuff.find_by(name: "dupLiveRun").value
      self.live_keymap = SupportStuff.find_by(name: "dupLiveKeyMap").value
      self.live_param = SupportStuff.find_by(name: "dupLiveParam").value
      self.live_batch = SupportStuff.find_by(name: "dupLiveBatch").value
      self.postrun0 = SupportStuff.find_by(name: "dupPostrun0").value
      self.postrun1 = SupportStuff.find_by(name: "dupPostrun1").value
      self.postrun2 = SupportStuff.find_by(name: "dupPostrun2").value
      self.postrun3 = SupportStuff.find_by(name: "dupPostrun3").value
      self.postrun4 = SupportStuff.find_by(name: "dupPostrun4").value
      self.flags = SupportStuff.find_by(name: "dupFlags").value
    else
      self.params_set = SupportStuff.find_by(name: "ddlParamsSet").value
      self.edd = SupportStuff.find_by(name: "ddlEdd").value
      self.prerun0 = SupportStuff.find_by(name: "ddlPrerun0").value
      self.prerun1 = SupportStuff.find_by(name: "ddlPrerun1").value
      self.prerun2 = SupportStuff.find_by(name: "ddlPrerun2").value
      self.prerun3 = SupportStuff.find_by(name: "ddlPrerun3").value
      self.prerun4 = SupportStuff.find_by(name: "ddlPrerun4").value
      self.live_run = SupportStuff.find_by(name: "ddlLiveRun").value
      self.live_keymap = SupportStuff.find_by(name: "ddlLiveKeyMap").value
      self.live_param = SupportStuff.find_by(name: "ddlLiveParam").value
      self.live_batch = SupportStuff.find_by(name: "ddlLiveBatch").value
      self.postrun0 = SupportStuff.find_by(name: "ddlPostrun0").value
      self.postrun1 = SupportStuff.find_by(name: "ddlPostrun1").value
      self.postrun2 = SupportStuff.find_by(name: "ddlPostrun2").value
      self.postrun3 = SupportStuff.find_by(name: "ddlPostrun3").value
      self.postrun4 = SupportStuff.find_by(name: "ddlPostrun4").value
      self.flags = SupportStuff.find_by(name: "ddlFlags").value
     end
    self.locales = SupportStuff.find_by(name: "azkLocales").value
    self.location =  SupportStuff.find_by(name: "azkLocation").value
  end
end