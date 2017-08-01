# Use an official ruby runtime as a parent image
FROM ruby:2.3-slim

# Set the working directory to /app
# Is this the working directory of the container? I think so...
WORKDIR /app

# Copy the current directories contents into the container at /app
# don't need to copy over the dockerfile or the yaml file
ADD quotes.rb boxes.rb /app/

# Run the ruby script when the container launches
ENTRYPOINT ["ruby", "quotes.rb"]
