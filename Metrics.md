# Metrics

Dieser Config-Server exponiert Micrometer-Metriken über `/actuator/prometheus`
(siehe `management.endpoints.web.exposure.include` in `bootstrap.properties`).

## Deaktivierte Metrik: `spring.cloud.config.environment.*`

In [application.yml](application.yml) ist folgender Block gesetzt:

```yaml
management:
  metrics:
    enable:
      spring.cloud.config.environment: false
```

### Warum

Spring Cloud Config Server misst jeden `find`-Aufruf des
`MultipleJGitEnvironmentRepository` als getaggten Timer/LongTaskTimer, z. B.:

```
spring_cloud_config_environment_find_seconds_count{application="...",class="...",label="...",profile="..."}
spring_cloud_config_environment_find_active_seconds_count{...}
```

Die Tags `spring_cloud_config_environment_application`,
`spring_cloud_config_environment_profile` und
`spring_cloud_config_environment_label` entsprechen dem jeweiligen
**Client**-App-Namen, -Profil und -Label, das den Config-Server anfragt —
nicht dem Config-Server selbst. Die Anzahl der resultierenden Zeitreihen
wächst also mit:

```
#Client-Apps × #Profile × #Labels
```

Bei einem zentralen Config-Server, der viele unterschiedliche Services und
Umgebungen bedient, kann diese Kombinatorik schnell zu einer hohen Anzahl an
Zeitreihen (Cardinality) im Prometheus-Server führen — inklusive höherem
Speicherbedarf und langsameren Queries dort. Der `management.metrics.enable`-
Präfix deaktiviert die gesamte `spring.cloud.config.environment`-Metrikfamilie
(sowohl den eigentlichen Timer als auch die `.active`-Variante) auf einen
Schlag.

### Wieder aktivieren

Falls die Metrik doch gebraucht wird (z. B. temporär zum Debuggen), reicht:

```yaml
management:
  metrics:
    enable:
      spring.cloud.config.environment: true
```

oder das Entfernen des Blocks (Default ist "enabled").

## Weitere potenzielle Cardinality-Risiken

- **Percentile-Histogramme**: `management.metrics.distribution.percentiles-histogram.*`
  ist aktuell nirgends gesetzt. Falls das in Zukunft aktiviert wird (z. B.
  `.all=true`), splittet jeder Timer in mehrere `_bucket`-Zeitreihen auf —
  klassischer Cardinality-Killer, nur gezielt für einzelne, wichtige Metriken
  aktivieren.
- **`http_server_requests_seconds`**: aktuell unkritisch, da Spring MVC die
  `uri`-Tags über die `@RequestMapping`-Templates (`/{name}/{profile}`)
  normalisiert statt die rohen Pfade zu verwenden. Bei eigenen Controllern mit
  dynamischen Pfaden im Blick behalten.
- **JVM-/Process-/System-Metriken** (`jvm_*`, `process_*`, `system_*`): fixe,
  niedrige Anzahl an Zeitreihen, unkritisch.
