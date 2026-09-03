from database.customer_queries import find_customer_by_email


customer = find_customer_by_email("riya.sharma@gmail.com")

print(customer)