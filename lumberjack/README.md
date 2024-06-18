log4shell usage, containe(likely docker escape)

only ssh and port 80 are open

possible error page exploit, need to look for vulnerable endpoints

```
	As a response header for the main body

	The first parameter in the HTTP context is either inline (default value, indicating it can be displayed inside the Web page, or as the Web page) or attachment (indicating it should be downloaded; most browsers presenting a 'Save as' dialog, prefilled with the value of the filename parameters if present).

	Content-Disposition: inline
	Content-Disposition: attachment
	Content-Disposition: attachment; filename="filename.jpg"
```
500        1l        1w        0c http://lumber.thm/error
200        1l        6w       29c http://lumber.thm/~logs

~logs/log4j "X-api-version" exploit 