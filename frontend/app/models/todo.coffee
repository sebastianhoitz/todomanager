Spine = require("spine")

class Todo extends Spine.Model
	@configure "Todo", "id", "subject", "done"

	@extend Spine.Model.Ajax

	@url: "/todo/index"

	@active: ->
		@select (item) -> !item.done

	@done: ->
		@select (item) -> !!item.done

module.exports = Todo
