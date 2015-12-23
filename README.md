[Scrapy](http://scrapy.org/) 1.0.3 environment with [Tor](https://www.torproject.org/) for anonymous ip routing and [Privoxy](http://www.privoxy.org/) for http proxy.

Run:

```
docker run -it mmast/scrapy-tor
```

Run a spider:
```
cd /my/scrapy/project
docker run -it -v $(pwd):/opt mmast/scrapy-tor crawl my_spider
```

Run scraping console:
```
cd /my/scrapy/project
docker run -it -v $(pwd):/opt mmast/scrapy-tor shell "http://web.to.scrape"
```

No further configuration is needed for the Scrapy settings, since the proxy middleware (`scrapy.downloadermiddlewares.httpproxy.HttpProxyMiddleware`) will be activated by default using the HTTP proxy address (http://127.0.0.1:8118) set up in the environment.

Extending with more requirements:

```
FROM mmast/scrapy-tor
ADD requirements.txt ./
RUN pip install -r requirements.txt
```

Extending with MongoDB:

```
FROM mmast/scrapy-tor
RUN pip install pymongo==3.2
```

```
docker build -t scrapy-tor-mongo .
docker run -v /path/to/data:/data/db --name mongodb -d mongo
docker run -it --link mongodb:mongodb scrapy-tor-mongo
```

```
# Scrapy project settings
import os
...
MONGO_HOST = os.environ['MONGODB_PORT_27017_TCP_ADDR']
MONGO_PORT = os.environ['MONGODB_PORT_27017_TCP_ADDR']
...
```

