from database.ticket_queries import create_service_ticket


ticket_id = create_service_ticket(
    1,
    1,
    "TV is showing a black screen",
    "HIGH"
)

print("Created Ticket ID:", ticket_id)