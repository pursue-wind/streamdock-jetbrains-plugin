/*
 * Copyright 2000-2024 JetBrains s.r.o. and contributors. Use of this source code is governed by the Apache 2.0 license.
 */

import {DefaultAction} from "./default-action";

export class StepIntoAction extends DefaultAction<StepIntoAction> {
  actionId(): string {
    return "StepInto";
  }

  actionTitle():string {
    return "Step\nInto";
  }
}
