import { createRouter } from '@backstage/plugin-auth-backend';
import { Router } from 'express';
import { PluginEnvironment } from '../types';
import {
   ldap,
   JWTTokenValidator,
} from '@immobiliarelabs/backstage-plugin-ldap-auth-backend';
import Keyv from 'keyv';


export default async function createPlugin(
    env: PluginEnvironment,
  ): Promise<Router> {
    return await createRouter({
      logger: env.logger,
      config: env.config,
      database: env.database,
      discovery: env.discovery,
      tokenManager: env.tokenManager,
      providerFactories: { 
        tokenValidator: new JWTTokenValidator(new Keyv()), 
        ldap: ldap.create({ /* Custom Configurations */ }), 
      },
    });
  }
      
      
        