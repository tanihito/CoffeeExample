# (($) ->
#   $.fn.bootstrapTransfer = () ->
#     _this = undefined

#     # #===============================================================================
#     # # Expose public functions
#     # #===============================================================================
#     @populate = (input) ->
#       _this.populate input

#     @set_values = (values) ->
#       _this.set_values values

#     @get_values = ->
#       _this.get_values()

#     @each ->
#       _this = $(this);

#       # #===============================================================================
#       # # Initialize internal variables
#       # #===============================================================================
#       _this.$remaining_select = _this.find("select.remaining")
#       _this.$target_select = _this.find("select.target")
#       _this.$add_btn = _this.find(".selector-add")
#       _this.$remove_btn = _this.find(".selector-remove")
#       _this.$choose_all_btn = _this.find(".selector-chooseall")
#       _this.$clear_all_btn = _this.find(".selector-clearall")
#       _this._remaining_list = []
#       _this._target_list = []

#       # #===============================================================================
#       # # Wire internal events
#       # #===============================================================================
#       _this.$add_btn.click ->
#         _this.move_elems _this.$remaining_select.val(), false, true

#       _this.$remove_btn.click ->
#         _this.move_elems _this.$target_select.val(), true, false

#       _this.$choose_all_btn.click ->
#         _this.move_all false, true

#       _this.$clear_all_btn.click ->
#         _this.move_all true, false


#       # #===============================================================================
#       # # Implement public functions
#       # #===============================================================================
#       _this.populate = (input) ->

#         # input: [{value:_, content:_}]
#         for i of input
#           e = input[i]
#           _this._remaining_list.push [
#             value: e.value
#             content: e.content
#           , true]
#           _this._target_list.push [
#             value: e.value
#             content: e.content
#           , false]
#         _this.update_lists true

#       _this.set_values = (values) ->
#         _this.move_elems values, false, true

#       _this.get_values = ->
#         _this.get_internal _this.$target_select


#       # #===============================================================================
#       # # Implement private functions
#       # #===============================================================================
#       _this.get_internal = (selector) ->
#         res = []
#         selector.find("option").each ->
#           res.push $(this).val()

#         res

#       _this.to_dict = (list) ->
#         res = {}
#         for i of list
#           res[list[i]] = true
#         res

#       _this.update_lists = (force_hilite_off) ->
#         _this.$remaining_select.empty()
#         _this.$target_select.empty()
#         lists = [_this._remaining_list, _this._target_list]
#         source = [_this.$remaining_select, _this.$target_select]
#         for i of lists
#           for j of lists[i]
#             e = lists[i][j]
#             if e[1]
#               selected = ""
#               selected = "selected=\"selected\""
#               source[i].append "<option " + selected + "value=" + e[0].value + ">" + e[0].content + "</option>"

#       _this.move_elems = (values, b1, b2) ->
#         for i of values
#           val = values[i]
#           for j of _this._remaining_list
#             e = _this._remaining_list[j]
#             if e[0].value is val
#               e[1] = b1
#               _this._target_list[j][1] = b2
#         _this.update_lists false

#       _this.move_all = (b1, b2) ->
#         for i of _this._remaining_list
#           _this._remaining_list[i][1] = b1
#           _this._target_list[i][1] = b2
#         _this.update_lists false

#       _this.data "bootstrapTransfer", _this
#       _this

# ) jQuery



class CsvFieldSelector
  constructor: (@remaining_fields, @target_fields) ->

  move: (fields, is_target) ->
    console.log(is_target)

  move_all: (is_target) ->
    all_fields = []
    all_fields.push(field) for field in @remaining_fields
    all_fields.push(field) for field in @target_fields
    if is_target
      @remaining_fields = []
      @target_fields    = all_fields
    else
      @remaining_fields = all_fields
      @target_fields    = []
    @update()

  update: () ->
    $(".bootstrap-transfer-container").find("select.remaining").empty()
    for remaining_field in @remaining_fields
      selected = ""
      $(".bootstrap-transfer-container").find("select.remaining").append "<option " + selected + ">" + remaining_field + "</option>"

    $(".bootstrap-transfer-container").find("select.target").empty()
    for target_field in @target_fields
      selected = ""
      $(".bootstrap-transfer-container").find("select.target").append "<option " + selected + ">" + target_field + "</option>"

$ ->
  remaining_fields = ["1", "2"]
  target_fields    = ["3", "4", "5"]
  field_selector = new CsvFieldSelector(remaining_fields, target_fields)
  field_selector.update()
  field_selector.move_all(true)
