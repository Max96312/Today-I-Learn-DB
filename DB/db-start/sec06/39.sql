select name, email
from customers;

select concat(name, email)
from customers;

select concat(name, ' (', email, ')') as name_and_email
from customers;

select concat_ws(' - ', name, email, address) as customer_details
from customers;

select email, upper(email)
from customers;

select name, char_length(name), length(name) as byte_length
from customers;