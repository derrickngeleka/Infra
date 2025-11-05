variable "build_resource_group"   { type = string }        # MUST already exist
variable "gallery_resource_group" { type = string }
variable "gallery_name"           { type = string }
variable "image_name"             { type = string }
variable "image_version"          { type = string }        # pipeline overrides per run
variable "replication_regions"    { type = list(string) }  # canonical names, e.g. ["centralus","eastus"]
