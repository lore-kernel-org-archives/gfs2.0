Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997644;
	b=L4+xvFT4uQ20xG+ZuAGntmjqoPuhjtHdOLZJxhTcozT6MLlzWjl+ehyAxvVi9MG3iTi3
	 DnsjY0ACBr+/M9wuxCNYKh0xLRq+eYi381W+E5F0RtUfbA3G+izbEe6H/DDwBKhn0VPEx
	 cIoe86m28cfuuaS7vFrJtvV//jFS3ogggvDp37mI5C+16irbS+4Hvpm67wL/z2LBdOD1B
	 QhqzDNLMCl/eZpZNo0eVsmUAh8r1EFjoXXNAYFzvSvWRWbhHixAP0OnCHFc5iog071Nww
	 RNdqhM91lK3TNFDgSB4dGrhJaiRPVl2+YwVzlZypAoaRMZ4/NoLnMK2SS7lY+qg6F2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997644;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=asCzidLH33YWNU16WvIudg/yxh48yMgZkyoiJj03RS0=;
	b=WeQjTyXlDNyAFEveWb2XLfxx1nd6mXgMNzEVb6ezjOqheJdjq86h5fiuzwrHFa2uPi4T
	 bfYWqxXCIWkNu7Vw22bhuJglxQGZNTQ8UtvDzJ/ArcCKxVzhK+0Q7OLnfdzPdbSlR1jSI
	 teHVaQIabrGc5RTnwSCTJu/YswBsEOuhfPeXIdQLSQJoxo7ljEJxXGl68jKD0QEVMvob1
	 9YXE6Rg9Kr/MLakh021dRgC9vSbwoHumSuYQ4s4bbGZwkfkWWFt6sJNF+4Zi8qRI+XfW5
	 BQjLSRCupuPBPu3PcatdjXQRqFuLTLYcs5R0kJkug0MaLXmmOiA/PvMxhSnLzBbShYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4SP1oQI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A23606A326
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A23606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4SP1oQI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793997643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asCzidLH33YWNU16WvIudg/yxh48yMgZkyoiJj03RS0=;
	b=h4SP1oQIvvxyLXV4JEc3EUNpCNX6vsQx4QzuGYFqnJeYcnpk9nfXM4Fg15Eld81UbTnVJU
	/dlPCtjmiRbrD6xNikAtHxRXncbka7GBNAoKGEx6JTLKZOMk4/ZUdx5qePlT53d8PzZqaD
	GTU0HtVVYpf3/fnAwqzIfOvR0r6OS9s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-muYQneHwP72ENjS2ubP4Qg-1; Fri,
 06 Nov 2026 15:40:41 -0500
X-MC-Unique: muYQneHwP72ENjS2ubP4Qg-1
X-Mimecast-MFC-AGG-ID: muYQneHwP72ENjS2ubP4Qg_1793997641
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E36318001FB
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:41 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 935E91955F19;
	Fri,  6 Nov 2026 20:40:40 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.4-rc1 3/4] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
Date: Fri,  6 Nov 2026 15:40:34 -0500
Message-ID: <20261106204035.3794411-4-aahringo@redhat.com>
In-Reply-To: <20261106204035.3794411-1-aahringo@redhat.com>
References: <20261106204035.3794411-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p5R6ZPvNAJJBEv9EJ2xeDCyUM32CUxPn2mzZCI5tLhs_1793997641
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Ameer Hamza <ameer.hamza@truenas.com>

When a local request reuses an inactive rsb, find_rsb_dir() sets
RSB_MASTER_UNCERTAIN if res_master_nodeid is not our nodeid. This also
matches an rsb that never got a master (res_master_nodeid 0, res_nodeid
-1). set_master() then trusts the "cached" master, copies res_nodeid -1
into lkb_nodeid and skips the lookup, and _request_lock() hits the
DLM_ASSERT(r->res_nodeid >= 0) in is_remote():

  rsb: nodeid -1 master 0 dir 1 flags 200 first 1 rlc 0 name pr
  Kernel panic - not syncing: DLM:  Record message above and reboot.
  Call Trace:
   _request_lock.cold+0x3e/0x3e [dlm]
   request_lock+0xcc/0x110 [dlm]
   dlm_user_request+0x110/0x340 [dlm]
   device_write+0x605/0x6d0 [dlm]

Such an rsb is left behind when a request is cancelled while its lookup
is still outstanding and the lockspace then recovers, e.g. because the
dir node died: dlm_recover_waiters_post() completes the cancelled lkb
instead of resending it, so no master is ever set. Once the rsb is
inactive, the next request for the name revives it and crashes as
above. If we became the dir node in that recovery, deactivate_rsb()
even keeps the rsb as a dir record, so it does not age out.

Before commit c04fecb4d9f7 ("dlm: use rsbtbl as resource directory")
the flag was only set when res_nodeid was > 0. Restore that and set the
flag only when a master is actually cached, so that set_master() does a
normal lookup (or becomes the master itself as dir node) for an rsb
that has none. res_first_lkid is still cleared, as the cancelled lkb
leaves a stale id behind.

Fixes: c04fecb4d9f7 ("dlm: use rsbtbl as resource directory")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ameer Hamza <ameer.hamza@truenas.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 3b3e15157f4c..934afc93464f 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -826,8 +826,12 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	if (from_local && (r->res_master_nodeid != our_nodeid)) {
 		/* Because we have held no locks on this rsb,
-		   res_master_nodeid could have become stale. */
-		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+		 * res_master_nodeid could have become stale.  If no master
+		 * was ever set, there is nothing to confirm and set_master()
+		 * must resolve it as for a new rsb.
+		 */
+		if (r->res_master_nodeid)
+			rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
 		r->res_first_lkid = 0;
 	}
 
-- 
2.43.0

