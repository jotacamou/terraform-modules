/**
 * Output variables ~
 */

output "stream_id" {
  value       = google_datastream_stream.stream.id
  description = "Id of the created stream"
}

output "connection_profile_id" {
  value       = google_datastream_connection_profile.cloudsql.id
  description = "Id of the created connection profile"
}
