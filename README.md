# Automatic Follow Friday

To use this script:

1. Generate a bearer token on your Mastodon instance.
2. Add it to a file called `token.txt`
3. Change the value of `HOSTNAME` to your instance hostname.
4. Run the script one of two ways:

```
bash follow.sh > follows.txt
cat follows.txt | shuf | tail -10
```

or 

```
bash follows.sh | shuf | tail -10
```
