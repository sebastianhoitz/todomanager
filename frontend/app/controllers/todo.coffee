Spine = require("spine")
$ = Spine.$
Model = require("models/todo")

console.log Model

class TodoItem extends Spine.Controller
	events:
		"change input[type=checkbox]": "toggle"
		"dblclick": "edit"
		"blur input[type=text]": "close"
		"keypress input[type=text]": "blurOnEnter"

	elements:
		"input[type=text]": "input"

	constructor: ->
		super
		@item.bind("update", @render)
		@item.bind("destroy", @remove)

	render: =>
		@log @item
		@replace $(require("views/todo/todo")(@item))
		@

	toggle: ->
		@item.done = !@item.done
		@item.save()

	edit: ->
		@el.addClass("editing")
		@input.focus()

	blurOnEnter: (e) ->
		if e.keyCode is 13 then e.target.blur()

	close: ->
		@el.removeClass("editing")
		@item.updateAttributes({subject: @input.val()})

	remove: =>
		@el.remove()

class Todo extends Spine.Controller
	events:
		"submit form": "create"
		"click .clear": "clear"

	elements:
		".items": "items"
		"form input": "input"
		".countVal": "count"

	constructor: ->
		super

		@log "Initialited"

		Model.bind "create", @addOne
		Model.bind "refresh", @addAll
		Model.bind "refresh change", @renderCount
		Model.fetch()

	# Add a single todo item
	addOne: (todo) =>
		view = new TodoItem(item: todo)

		@items.append view.render().el

	# After a refresh
	addAll: =>
		Model.each @addOne

	# Create a new todo
	create: (e) ->
		e.preventDefault()
		@log @input.val()
		Model.create(subject: @input.val())
		@input.val ""

	renderCount: =>
		active = Model.active().length
		@count.text(active)

module.exports = Todo
