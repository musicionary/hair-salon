# Hair Salon
 Project focusing on Ruby routing, PostgreSQL, rspec testing and Capybara unit testing, and user input in a site that allows a hair salon owner to manage the salon's various stylists and clients.   The home page displays a list of words, and when clicked, shows their definition.  Also uses materialize framework and additional css styling

## Installation

1. Clone this repository from https://github.com/musicionary/hair-salon
2. Run bundle install from your command line
3. If you don't already have it, download the postgres and psql packages using your computer's specific package manager.
  * If on a mac use Homebrew:
    * brew install postgres
    * brew install psql
4. In psql, create a production and development database named hair_salon and hair_salon_test, respectively.
  * CREATE DATABASE hair_salon;
  * CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;

  * CREATE TABLE stylists (id serial PRIMARY KEY, name varchar, station varchar);
  * CREATE TABLE clients (id serial PRIMARY KEY, name varchar, next_appointment timestamp, stylist_id int);

Create an application for a hair salon. The stylists at the salon work independently, so each client will only belong to a single stylist (one stylist, many clients).


As a salon owner, I want to add clients to a stylist.





## Usage

In your terminal, run 'ruby app.rb' to start the Sinatra local server and point your browser to localhost:4567

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

By Chip Carnes

## License

MIT License. Copyright &copy; 2016 "Chip Carnes"
