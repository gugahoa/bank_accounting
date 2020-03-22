RETRIES=3

until pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER || [ $RETRIES -eq 0 ]; do
  echo "$(date) - Trying to connect to database... $((RETRIES--)) retries remaining..."
  sleep 1
done

if [[ -z `psql -lqt | cut -d \| -f 1 | grep -wq $PGDATABASE` ]];
then
  echo "Database $PGDATABASE doesn't exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs

  echo "Database successfully created"
fi

exec mix phx.server
