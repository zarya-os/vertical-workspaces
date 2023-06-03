UUID = vertical-workspaces@zarya.com
BASE_MODULES = extension.js \
			   metadata.json \
			   LICENSE \
			   $(NULL)

ifeq ($(strip $(DESTDIR)),)
	INSTALLTYPE = local
	INSTALLBASE = $(HOME)/.local/share/gnome-shell/extensions
else
	INSTALLTYPE = system
	SHARE_PREFIX = $(DESTDIR)/usr/share
	INSTALLBASE = $(SHARE_PREFIX)/gnome-shell/extensions
endif
INSTALLNAME = vertical-workspaces@zarya.com

# The command line passed variable VERSION is used to set the version string
# in the metadata and in the generated zip-file. If no VERSION is passed, the
# current commit SHA1 is used as version number in the metadata while the
# generated zip file has no string attached.
ifdef VERSION
	VSTRING = _v$(VERSION)
else
	VERSION = $(shell git rev-parse HEAD)
	VSTRING =
endif

all: extension

clean:
	rm -f ./schemas/gschemas.compiled
	rm -rf _build

extension: ./schemas/gschemas.compiled

./schemas/gschemas.compiled: ./schemas/org.gnome.shell.extensions.vertical-workspaces.gschema.xml
	glib-compile-schemas ./schemas/

install: install-local

install-local: _build
	rm -rf $(INSTALLBASE)/$(INSTALLNAME)
	mkdir -p $(INSTALLBASE)/$(INSTALLNAME)
	cp -r ./_build/* $(INSTALLBASE)/$(INSTALLNAME)/
ifeq ($(INSTALLTYPE),system)
	# system-wide settings
	mkdir -p $(SHARE_PREFIX)/glib-2.0/schemas
	cp -r ./schemas/*gschema.* $(SHARE_PREFIX)/glib-2.0/schemas
endif
	-rm -fR _build
	echo done

zip-file: _build check
	cd _build ; \
	zip -qr "$(UUID)$(VSTRING).zip" .
	mv _build/$(UUID)$(VSTRING).zip ./
	-rm -fR _build

_build: all
	-rm -fR ./_build
	mkdir -p _build
	cp  $(BASE_MODULES) _build
	cp -r lib _build
	cp stylesheet.css _build
	mkdir -p _build/schemas
	cp schemas/*.xml _build/schemas/
	cp schemas/gschemas.compiled _build/schemas/
	sed -i 's/"version": -1/"version": "$(VERSION)"/'  _build/metadata.json;