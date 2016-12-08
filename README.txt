Overall site config
-------------------

  _data/settings.yml

Settings here include what to show on the landing page.


Editing/adding news posts
-------------------------

  _news/*.md

File names should start with a date in the form YYYY-MM-DD. The format is
Markdown, but files begin with "front matter" between two "---" lines, which
is yml formatted. Current front matter variables used:

  title: The title of the post
  excerpt: Optional short description to show in lists. If not provided,
    everything up to the excerpt delimiter (defined in _data/settings.yml) will
    be used, or the entire post if there is no delimiter.


Editing/adding data
-------------------

	_people/*.md
	_projects/*.md
	_data/publications/*.yml

Pages for People and Projects are entirely generated from data, and Markdown
content below the "front matter" (between the "---" lines) is currently ignored.
Publications are only used as a data source and do not have individual pages,
hence the pure yml format. See existing files for relevant variables. Note that
while there is no strict naming format for the Markdown or yml files, they will
be ordered by their file names when they appear in lists (reversed for
publications). It is thus useful for publications to begin with a date of the
form YYYY-MM-DD.

Images can be placed in img/ and can be referenced from yml as "/img/[...]",
including any subdirectories.
