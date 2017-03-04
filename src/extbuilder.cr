module ExtBuilder
  VERSION = "0.0.1"

  macro ext(srcdir, static st, output dir = "#\{__DIR__\}../ext/")
    {% if st %}
      {{ run "./extbuilder/builder.cr", srcdir, dir, "--static"}}
    {% else %}
      {{ run "./extbuilder/builder.cr", srcdir, dir}}
    {% end %}
  end
end
