Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24015B55D
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002244; cv=none; b=FH07xLxbjyBt9l8Yo3RjVPz3NjhzRE6SRXVs+SzY5Q6SS4rX9x8+ID14QW7QTBGyzdBmm1BmlNSnnlhDdEoIW3buQXN+SCBEejKk+IVfHvOcq8+US1fCF1SWar9+0c8SrVADCUrHlSWu9gSE4fagxCU8UFFXDLmKiVXs/Dh2OxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002244; c=relaxed/simple;
	bh=7vz5wNVaB71Wt7rnIKc5cX45diURkUG9KjGDWWb5o+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8h9NvqkR+W03xaFbVT9Y7cfn9AYAQRzMUUQMpOjFXAtckz2zLEPPEHc7F1eiuWL1qpxw9Zq1sXz20kTKW/+zpnDvpqUt+a6m+Zc6iATHzrbfTfWVN1vd5rm/MTpwtmY4csSnc0WX5ePAZCLI7q0ZxXI80Or+zN4eQHz5IEfOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jz74ffxy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz74ffxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAJrFL2iXVGBr6/M0JwIS+/wiKjZKuEwyroGXfxBWuU=;
	b=Jz74ffxyK8+Ax8/YzrsR0Ix6uIQgnL5JJEfFIxZAhpdUOJ8y92xwM0EujwpxiEX57ZkLVG
	aw2qzZqeVn0HKThNLBn1HdIl4rjQt5tx2TTlvWevruVU2mqeTCqX/OBwBh37ZeDM9WQQap
	uKoGpqVRIcousBd3fch1qUKAMmkHf0k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-lMvFh8OXMGmt5tK0L3Im4Q-1; Wed,
 29 May 2024 13:03:59 -0400
X-MC-Unique: lMvFh8OXMGmt5tK0L3Im4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BED03C025B2
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:59 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4855492BC6;
	Wed, 29 May 2024 17:03:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/15] gfs2: Update glocks documentation
Date: Wed, 29 May 2024 19:03:44 +0200
Message-ID: <20240529170352.571141-8-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Rearrange the table of locking modes and associated caching capability
to be in order of increasing caching capability.

Update the description of the glock operations.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 Documentation/filesystems/gfs2-glocks.rst | 52 +++++++++++------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2-glocks.rst
index 8a5842929b60..17ce3413608a 100644
--- a/Documentation/filesystems/gfs2-glocks.rst
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -40,14 +40,14 @@ shared lock mode, SH. In GFS2 the DF mode is used exclusively for direct I/O
 operations. The glocks are basically a lock plus some routines which deal
 with cache management. The following rules apply for the cache:
 
-==========      ==========   ==============   ==========   ==============
-Glock mode      Cache data   Cache Metadata   Dirty Data   Dirty Metadata
-==========      ==========   ==============   ==========   ==============
-    UN             No              No             No            No
-    SH             Yes             Yes            No            No
-    DF             No              Yes            No            No
-    EX             Yes             Yes            Yes           Yes
-==========      ==========   ==============   ==========   ==============
+==========      ==============   ==========   ==========   ==============
+Glock mode      Cache Metadata   Cache data   Dirty Data   Dirty Metadata
+==========      ==============   ==========   ==========   ==============
+    UN                No            No            No            No
+    DF                Yes           No            No            No
+    SH                Yes           Yes           No            No
+    EX                Yes           Yes           Yes           Yes
+==========      ==============   ==========   ==========   ==============
 
 These rules are implemented using the various glock operations which
 are defined for each type of glock. Not all types of glocks use
@@ -55,23 +55,24 @@ all the modes. Only inode glocks use the DF mode for example.
 
 Table of glock operations and per type constants:
 
-=============      =============================================================
+==============     =============================================================
 Field              Purpose
-=============      =============================================================
-go_xmote_th        Called before remote state change (e.g. to sync dirty data)
+==============     =============================================================
+go_sync            Called before remote state change (e.g. to sync dirty data)
 go_xmote_bh        Called after remote state change (e.g. to refill cache)
 go_inval           Called if remote state change requires invalidating the cache
 go_demote_ok       Returns boolean value of whether its ok to demote a glock
                    (e.g. checks timeout, and that there is no cached data)
-go_lock            Called for the first local holder of a lock
-go_unlock          Called on the final local unlock of a lock
+go_instantiate     Called when a glock has been acquired
+go_held            Called every time a glock holder is acquired
 go_dump            Called to print content of object for debugfs file, or on
                    error to dump glock to the log.
-go_type            The type of the glock, ``LM_TYPE_*``
 go_callback	   Called if the DLM sends a callback to drop this lock
+go_unlocked        Called when a glock is unlocked (dlm_unlock())
+go_type            The type of the glock, ``LM_TYPE_*``
 go_flags	   GLOF_ASPACE is set, if the glock has an address space
                    associated with it
-=============      =============================================================
+==============     =============================================================
 
 The minimum hold time for each lock is the time after a remote lock
 grant for which we ignore remote demote requests. This is in order to
@@ -82,26 +83,25 @@ to by multiple nodes. By delaying the demotion in response to a
 remote callback, that gives the userspace program time to make
 some progress before the pages are unmapped.
 
-There is a plan to try and remove the go_lock and go_unlock callbacks
-if possible, in order to try and speed up the fast path though the locking.
-Also, eventually we hope to make the glock "EX" mode locally shared
-such that any local locking will be done with the i_mutex as required
-rather than via the glock.
+Eventually, we hope to make the glock "EX" mode locally shared such that any
+local locking will be done with the i_mutex as required rather than via the
+glock.
 
 Locking rules for glock operations:
 
-=============    ======================    =============================
+==============   ======================    =============================
 Operation        GLF_LOCK bit lock held    gl_lockref.lock spinlock held
-=============    ======================    =============================
-go_xmote_th           Yes                       No
+==============   ======================    =============================
+go_sync               Yes                       No
 go_xmote_bh           Yes                       No
 go_inval              Yes                       No
 go_demote_ok          Sometimes                 Yes
-go_lock               Yes                       No
-go_unlock             Yes                       No
+go_instantiate        No                        No
+go_held               No                        No
 go_dump               Sometimes                 Yes
 go_callback           Sometimes (N/A)           Yes
-=============    ======================    =============================
+go_unlocked           Yes                       No
+==============   ======================    =============================
 
 .. Note::
 
-- 
2.45.1

