library(
    identifier: 'pipeline-lib@4.8.0',
    retriever: modernSCM([$class: 'GitSCMSource',
                          remote: 'https://github.com/SmartColumbusOS/pipeline-lib',
                          credentialsId: 'jenkins-github-user'])
)

properties([
    pipelineTriggers([scos.dailyBuildTrigger()]),
])

def doStageIf = scos.&doStageIf
def doStageIfRelease = doStageIf.curry(scos.changeset.isRelease)
def doStageUnlessRelease = doStageIf.curry(!scos.changeset.isRelease && !scos.changeset.isHotfix)
def doStageIfPromoted = doStageIf.curry(scos.changeset.isMaster)
def doStageIfHotfix = doStageIf.curry(scos.changeset.isHotfix)

node('infrastructure') {
    ansiColor('xterm') {

        scos.doCheckoutStage()

        doStageUnlessRelease('Deploy to Dev') {
            deployLoggingTo('dev')
        }

         doStageIfPromoted('Deploy to Staging') {
            deployLoggingTo('staging')

            scos.applyAndPushGitHubTag('staging')
        }

        doStageIfRelease('Deploy to Production') {
            def releaseTag = env.BRANCH_NAME
            def promotionTag = 'prod'

            deployLoggingTo('prod')

            scos.applyAndPushGitHubTag(promotionTag)
        }
    }
}

def deployLoggingTo(environment) {
    scos.withEksCredentials(environment) {
        def terraformOutputs = scos.terraformOutput(environment)
        def subnets = terraformOutputs.public_subnets.value.join(/\\,/)
        def albToClusterSG = terraformOutputs.allow_all_security_group.value
        def dns_zone = environment + '.internal.smartcolumbusos.com'
        def certificateARN = terraformOutputs.tls_certificate_arn.value

        sh("""#!/bin/bash

            helm dependency update
            helm upgrade --install lexlogger . \
                --namespace=lexlogger \
                --set global.ingress.annotations."alb\\.ingress\\.kubernetes\\.io\\/subnets"="${subnets}" \
                --set global.ingress.annotations."alb\\.ingress\\.kubernetes\\.io\\/security\\-groups"="${albToClusterSG}" \
                --set global.ingress.annotations."alb\\.ingress\\.kubernetes\\.io\\/certificate-arn"="${certificateARN}" \
                --set kibana.ingress.hosts[0]="kibana\\.${dns_zone}" \
                --values values.yaml \
                --values values-curator.yaml
        """.trim())
    }
}
