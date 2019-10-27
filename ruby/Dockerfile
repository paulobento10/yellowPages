FROM ruby:2.5.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /home/ruby/myapp
COPY ./ruby/myapp/ .
#COPY ./ruby/myapp/Gemfile.lock .
RUN gem install bundler && bundle install

# Add a script to be executed every time the container starts.
COPY ./ruby/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#RUN rake db:drop db:create db:migrate

# Start the main process.
#CMD rails server -b 0.0.0.0
#CMD rake db:migrate & rails server -b 0.0.0.0
COPY ./ruby/open_terminal.sh /usr/bin/
RUN chmod +x /usr/bin/open_terminal.sh
CMD open_terminal.sh & rails server -b 0.0.0.0

#CMD bundle exec rails s -p 3000 -b 0.0.0.0
#-b 0.0.0.0
