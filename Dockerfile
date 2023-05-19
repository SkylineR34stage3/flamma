FROM ruby:3.1.4

# Set the working directory
WORKDIR .

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]
