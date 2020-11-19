replicaCount: 3

roleArn: "${role_arn}"

ingress:
    host:
        host: "${ingress_hosts}"
        paths: "/*"
    enabled: true
    annotations:
        kubernetes.io/ingress.class: alb
        alb.ingress.kubernetes.io/scheme: internal
        alb.ingress.kubernetes.io/actions.ssl-redirect: '{"Type": "redirect", "RedirectConfig": { "Protocol: "HTTPS", "Port": "443", "StatusCode": "HTTP_301"}}'
        alb.ingress.kubernetes.io/healthcheck-path: /
        alb.ingress.kubernetes.io/certificate-arn: ${certificate_arn}
        alb.ingress.kubernetes.io/listen-ports: '[{ "HTTPS": 443 }, { "HTTP": 80 }]' 
        alb.ingress.kubernetes.io/security-groups: ${alb_sg}
        alb.ingress.kubernetes.io/success-codes: "200"
        alb.ingress.kubernetes.io/tags: Environment=${environment}, App=${application}

service:
    type: NodePort
    port: 80

image:
    repository: ${image}
    tags: ${tags}
    pullPolicy: Always

resources:
    limits:
        cpu: ${resources_limits_cpu}
        memory: ${resources_limits_memory}
    requests:
        limits:
        cpu: ${resources_requests_cpu}
        memory: ${resources_requests_memory}

nodeSelector: {}

affinity: {}

tolerations: {}

env:
    APP: "${application}"
    ENV: "${environment}"
    REGION: "${region}"
    JVM_OPTIONS: "${jvm_options}"
