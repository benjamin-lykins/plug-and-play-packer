locals {
  timestamp          = formatdate("YYYYMMDDhhmmss", timestamp()) # Year Month Day Hour Minute Second with padding.
    time          = formatdate("YYYYMMDDhhmmss", timestamp()) # Year Month Day Hour Minute Second with padding.
  patch_version = formatdate("YYYYMMDD", timestamp())       # Year Month Day Hour Minute Second with padding.
}