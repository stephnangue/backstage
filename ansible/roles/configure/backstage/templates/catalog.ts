

import type { Router } from 'express'; 
import type { PluginEnvironment } from '../types'; 
import { CatalogBuilder } from '@backstage/plugin-catalog-backend'; 
import { ScaffolderEntitiesProcessor } from '@backstage/plugin-scaffolder-backend'; 
import { LdapOrgEntityProvider, } from '@backstage/plugin-catalog-backend-module-ldap'; 

export default async function createPlugin( 
  env: PluginEnvironment,
): Promise<Router> { 
  const builder = await CatalogBuilder.create(env); 
  builder.addEntityProvider( 
    LdapOrgEntityProvider.fromConfig(env.config, { 
        id: 'ldap_toolchain', 
        target: 'ldap://ipaserver.devopslab.ded.stet', 
        logger: env.logger, 
        schedule: env.scheduler.createScheduledTaskRunner({ 
          frequency: { minutes: 60 },
          timeout: { minutes: 15 },
        }), 
    }), 
    ); 
  builder.addProcessor(new ScaffolderEntitiesProcessor()); 
  const { processingEngine, router } = await builder.build(); 
  await processingEngine.start(); 
  return router; 
}