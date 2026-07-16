def _ds_string(value):
    underlying = value.GetChildMemberWithName('underlying')
    if not underlying.IsValid():
        return None
    summary = underlying.GetSummary()
    return summary.strip('"') if summary else underlying.GetValue()


def date_summary(value, _dict):
    try:
        address = value.AddressOf().GetValueAsUnsigned(0)
        if not address:
            return '<no address>'
        iso = value.CreateValueFromExpression('iso', f'((const ds::date::Date*)0x{address:x})->toIsoExtendedString()')
        return _ds_string(iso) or '<unreadable Date>'
    except Exception:
        return '<unreadable Date>'


def decimal_summary(value, _dict):
    try:
        address = value.AddressOf().GetValueAsUnsigned(0)
        if not address:
            return '<no address>'
        serialized = value.CreateValueFromExpression('serialized', f'((const ds::number::Decimal*)0x{address:x})->serialize()')
        return _ds_string(serialized) or '<unreadable Decimal>'
    except Exception:
        return '<unreadable Decimal>'


def optional_decimal_summary(value, _dict):
    try:
        address = value.AddressOf().GetValueAsUnsigned(0)
        if not address:
            return '<no address>'
        has_value = value.CreateValueFromExpression('has_value', f'((const ds::Optional<ds::number::Decimal>*)0x{address:x})->hasValue()')
        if not has_value.GetValueAsUnsigned(0):
            return 'none'
        decimal = value.CreateValueFromExpression('decimal', f'((const ds::Optional<ds::number::Decimal>*)0x{address:x})->get()')
        return decimal_summary(decimal, _dict)
    except Exception:
        return '<unreadable Optional<Decimal>>'


def __lldb_init_module(debugger, _dict):
    debugger.HandleCommand('type summary add -F ds4_lldb_formatters.date_summary "ds::date::Date"')
    debugger.HandleCommand('type summary add -F ds4_lldb_formatters.decimal_summary "ds::number::Decimal"')
    debugger.HandleCommand('type summary add -F ds4_lldb_formatters.optional_decimal_summary "ds::Optional<ds::number::Decimal>"')
