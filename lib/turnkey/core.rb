module Turnkey

  def archive(instance, key)
    if instance.is_a? Array
      archive_array(instance, key)
    else
      archive_instance(instance, key)
    end
  end

  module_function :archive

  private

  def self.archive_instance(instance, key)
    extend_protocols_to_obj_and_refs(instance)
    archived_data = NSKeyedArchiver.archivedDataWithRootObject(instance)
    user_defaults[key] = archived_data
  end

  def self.archive_array(array, key)
    array.each{|inst| extend_protocols_to_obj_and_refs(inst)}
    archive_instance(array, key)
  end

  def self.extend_protocols_to_obj_and_refs(instance)
    Utility.defineProtocols(instance)
    Utility.extend_protocols_to_object_references(instance)
  end

  def self.user_defaults
    NSUserDefaults.standardUserDefaults
  end

end