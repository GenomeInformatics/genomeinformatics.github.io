Building locally
----------------

Install the jekyll Ruby module(s):

 [ >export GEM_HOME=~/.gem # if you don't have admin rights ]
   >gem install jekyll
   >gem install jekyll-paginate # for multipage blog listings

Run jekyll in 'watch' mode to update as you modify files (restart if _config.yml
   changes):

   jekyll serve --watch &

View the locally served page at:

  http://127.0.0.1:4000


Overall site config
-------------------

   _data/settings.yml

Settings here include what to show on the landing page.


Editing/adding news posts
-------------------------

   _news/*.md

File names should start with a date in the form YYYY-MM-DD. The format is
Markdown, but files begin with "front matter" between two "---" lines, which
is yml formatted and used for metadata. Current front matter variables used:

  title: The title of the post
  excerpt: Optional short description to show in lists. If not provided,
    everything up to the excerpt delimiter (defined in _data/settings.yml) will
    be used, or the entire post if there is no delimiter.


Editing/adding data
-------------------

   _people/*.md
   _projects/*.md
   _data/publications/*.yml

For People and Projects, file names will be used for sorting, and the prefixes
for these and for Publications (no ".md" or ".yml") can be used as keys for
cross-referencing in the yml "front matter" (between the "---" lines). Though
files for People and Projects are Markdown formatted, the data in their yml
front matter is used to generate their corresponding pages, and Markdown content
below this is currently ignored. Publications are only used as a data source and
do not have individual pages, hence the pure yml format. See existing files for
relevant variables.

Images can be placed in img/ and can be referenced from yml as "/img/[...]",
including any subdirectories.
