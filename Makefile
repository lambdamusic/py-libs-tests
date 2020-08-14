# == Build logic Sphinx ==============================================
#
#  based on api-lab approach - see that for more info
#
# ===========================================================================

SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
#
SOURCEDIR     = sphinx

# update as needed locally - full path
BUILDDIR_STAGING = /Users/michele.pasin/tmp/py-libs-test-docs-staging-export

# folder for github docs
BUILDDIR_LIVE = docs
#
NOTEBOOKS_SOURCE = notebooks  # src of ipynb
NOTEBOOKS_COPY   = notebooks  # folder name in generated docs, for html versions of ipynb


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

html:
	@echo "==== STAGING documentation ===="
	@echo "==== ==== ==== ==== ==== ===="
	rm -rf $(SOURCEDIR)/$(NOTEBOOKS_COPY)
	cp -r $(NOTEBOOKS_SOURCE)  $(SOURCEDIR)/$(NOTEBOOKS_COPY)
	@$(SPHINXBUILD) -b $@ "$(SOURCEDIR)" "$(BUILDDIR_STAGING)"
	open $(BUILDDIR_STAGING)/index.html
	@echo "==== Staging documentation generated in ~/tmp/docs folder run - TIP use *make github* to finalize ===="


github:
	@echo "==== LIVE documentation ===="
	@echo "==== ==== ==== ==== ==== ===="
	rm -rf $(SOURCEDIR)/$(NOTEBOOKS_COPY)
	cp -r $(NOTEBOOKS_SOURCE)  $(SOURCEDIR)/$(NOTEBOOKS_COPY)
	@$(SPHINXBUILD) -b html "$(SOURCEDIR)" "$(BUILDDIR_LIVE)"
	open $(BUILDDIR_LIVE)/index.html
	@echo "==== LIVE documentation generated - in main /docs folder ===="
	@echo "==== Pushing to github ===="
	git add -A
	git commit -m "github pages docs"
	git push

