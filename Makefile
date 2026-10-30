LESSONS = $(sort $(patsubst %/.latexmkrc,%,$(wildcard */.latexmkrc)))
# Short keys, one 'key lesson' line each in .keys, as in p's list
KEYS    = $(shell awk '{print $$1}' .keys)

.DEFAULT_GOAL := help

# The lesson is the word after the command, make build networking or make build net. Every
# word is also a goal, so each lesson and each key is a target: alone, make net, it builds;
# after a command, it does nothing.
WORD   := $(firstword $(filter $(LESSONS) $(KEYS),$(MAKECMDGOALS)))
LESSON := $(or $(filter $(WORD),$(LESSONS)),$(shell awk -v k='$(WORD)' '$$1 == k {print $$2}' .keys))
ifeq ($(filter build open clean list help,$(MAKECMDGOALS)),)
$(LESSONS) $(KEYS): build
else
$(LESSONS) $(KEYS): ; @:
endif

# A word that is neither a command nor a lesson is a mistyped lesson.
UNKNOWN = $(filter-out build open clean list help $(LESSONS) $(KEYS),$(MAKECMDGOALS))
ifneq ($(UNKNOWN),)
  $(error No lesson called $(UNKNOWN): it is one of: $(LESSONS))
endif

# Every command but help and list works on one lesson.
ifneq ($(filter-out help list $(LESSONS) $(KEYS),$(MAKECMDGOALS)),)
  ifeq ($(LESSON),)
    $(error No lesson: add one, make <command> <lesson>, from: $(LESSONS))
  endif
endif

build:
	cd $(LESSON) && latexmk

open: build
	open -a Skim $(LESSON)/build/$(LESSON).pdf

clean:
	cd $(LESSON) && latexmk -C

list:
	@for l in $(LESSONS); do \
	  k=$$(awk -v l=$$l '$$2 == l {print "[" $$1 "]"}' .keys); printf '%-7s%s\n' "$$k" $$l; \
	done

# Bold and cyan only on a terminal, so piped help stays plain text.
help:
	@if [ -t 1 ]; then b=$$(tput bold); c=$$(tput setaf 6); n=$$(tput sgr0); fi; \
	printf "$${b}<lesson>$${n}                  one of $${c}make list$${n}, by name or [key]\n\n"; \
	printf "$${c}make build$${n} $${b}<lesson>$${n}       build the PDF, <lesson>/build/<lesson>.pdf\n"; \
	printf "$${c}make$${n} $${b}<lesson>$${n}             the same\n"; \
	printf "$${c}make open$${n} $${b}<lesson>$${n}        build it, then open it in Skim\n"; \
	printf "$${c}make clean$${n} $${b}<lesson>$${n}       remove its build/ files\n\n"; \
	printf "$${c}make list$${n}                 the lessons\n"; \
	printf "$${c}make help$${n}                 this list; also plain make\n"

.PHONY: build open clean list help
