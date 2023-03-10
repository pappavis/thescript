import pyshorteners

if __name__ == '__main__':
    s = pyshorteners.Shortener(api_key="YOUR_KEY")

    long_url = input(f"Enter the URL to shorten: ")

    short_url = s.bitly.short(long_url)

    print(f"The shortened URL is: {short_url}")
