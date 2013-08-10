# Usage:
# date.to_formatted_s(:kyc_long_date)

Time::DATE_FORMATS[:kyc_short_date] = "%-m/%e/%Y"
Time::DATE_FORMATS[:kyc_long_date] = "%B %e, %Y"