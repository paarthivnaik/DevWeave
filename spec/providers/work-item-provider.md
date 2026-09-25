# WorkItemProvider Interface Specification

## Abstract Contract

```typescript
export interface ClientInfo {
  toolName: string;
  isInstalled: boolean;
  version?: string;
  installCommandHint?: string;
}

export interface AuthStatus {
  isAuthenticated: boolean;
  authType: 'cli' | 'token' | 'pat' | 'oauth' | 'sso' | 'manual' | 'environment';
  userPrincipal?: string;
  error?: string;
}

export interface NormalizedWorkItem {
  work_item_id: string;
  title: string;
  description: string;
  type: string;
  status: string;
  priority: string;
  assignee?: string;
  reporter?: string;
  labels: string[];
  iteration?: string;
  created_at: string;
  updated_at?: string;
  acceptance_criteria: string[];
  source: {
    provider: string;
    url?: string;
    project?: string;
    key?: string;
  };
  comments?: Array<{
    id: string;
    author: string;
    created_at: string;
    text: string;
  }>;
  attachments?: Array<{
    id: string;
    filename: string;
    content_type?: string;
    size_bytes?: number;
    category: 'TEXT' | 'DOCUMENT' | 'IMAGE' | 'ARCHIVE' | 'OTHER';
    extracted_text?: string;
    ocr_status?: 'SUCCESS' | 'PARTIAL' | 'FAILED' | 'NOT_APPLICABLE';
    ocr_confidence?: number;
    evidence_reference?: string;
  }>;
  linked_items?: Array<{
    id: string;
    relationship: string;
    title: string;
    status?: string;
  }>;
  related_historical_work?: Array<{
    id: string;
    title: string;
    relevance_reason: string;
    status?: string;
  }>;
  provider_metadata?: Record<string, any>;
}

export interface WorkItemProvider {
  readonly name: string;
  detect(): Promise<boolean>;
  detectClient(): Promise<ClientInfo>;
  isInstalled(): Promise<boolean>;
  authenticationStatus(): Promise<AuthStatus>;
  authenticate(interactive?: boolean): Promise<AuthStatus>;
  fetchWorkItem(id: string): Promise<NormalizedWorkItem>;
  fetchComments(id: string): Promise<Array<NormalizedWorkItem['comments'][0]>>;
  fetchAttachments(id: string): Promise<Array<NormalizedWorkItem['attachments'][0]>>;
  downloadAttachment(id: string, attachmentId: string, targetPath: string): Promise<string>;
  extractAttachmentText(filePath: string): Promise<string>;
  processImageOCR(imagePath: string): Promise<{ text: string; confidence: number; status: string }>;
  fetchLinks(id: string): Promise<Array<NormalizedWorkItem['linked_items'][0]>>;
  searchRelated(query: string): Promise<Array<NormalizedWorkItem['related_historical_work'][0]>>;
}
```
