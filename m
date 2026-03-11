Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5D372EC6
	for <gfs2@lists.linux.dev>; Wed, 11 Mar 2026 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211363; cv=none; b=pMLGzlbz9xvw3i3dqJdXFwLL26QiQuhh65E++K1oUtuwjzRP7mYBtUPOe7YUikqyim4eYA8bL5j7El6xvy9/RiWsKdrhqirWZr5utKhRKxfsmeqN/KGEGmDUwU/8pvhBJgnEukDoVh7/BqRbjQstCbfDsLOKuG9rS1Yf1CyQvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211363; c=relaxed/simple;
	bh=IJUIZ/SyNsW4EXCyNuIdgJHBGuEpoBRinchPum5MOH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqOXqEmF/PxkbpI9kqigdarhD6Fdrq/m1t4FXHClsHYN3StDhzbJ/PvBp1XFgoiLpbLmjsgHw1rHplyigVi8QC1qiN49kZDcQ6w0UK/BZ+cDBB7C942/QxM4x15+axoEH0gpYfledtFO09NusPM8ZGW4E9z3VPlsF+J0BUlUw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LyfPi5nL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LyfPi5nL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40915C4CEF7;
	Wed, 11 Mar 2026 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773211362;
	bh=IJUIZ/SyNsW4EXCyNuIdgJHBGuEpoBRinchPum5MOH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyfPi5nLr28E30gofCv8GZTjVjYr3uYRuueyazHwnyfAFCc9TPjNThTNXPkqqDpKl
	 NwEp1S80sQVichReVAgev6bHGMLctlQcxPM0r6yuNkbmCOFVpHey7CMQrAKtXpGXR/
	 kkkfp4/IjPbbLnmMBTpLKfnYX1pL6D7e/XpQEmg0=
Date: Wed, 11 Mar 2026 07:42:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: can-yildirim@ymail.ne.jp
Cc: "security@kernel.org" <security@kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"aahringo@redhat.com" <aahringo@redhat.com>,
	"teigland@redhat.com" <teigland@redhat.com>
Subject: Re: [vs] DLM debugfs information disclosure via non-null-terminated
 resource name
Message-ID: <2026031118-shower-darkened-3e3a@gregkh>
References: <173757593.643632.1773164229041.ref@mail.yahoo.co.jp>
 <173757593.643632.1773164229041@mail.yahoo.co.jp>
 <2098115699.650906.1773192682434@mail.yahoo.co.jp>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2098115699.650906.1773192682434@mail.yahoo.co.jp>

On Wed, Mar 11, 2026 at 10:31:22AM +0900, can-yildirim@ymail.ne.jp wrote:
> Dear maintainers,
> There is an possible information disclosure vulnerability in the DLM
> subsystem's debugfs interface.

debugfs is, by default, only readable by root, and contains loads of
stuff like this, as it's full of debug information on the system.  So
much so that many systems do not enable it in their kernels, and others
do not mount it at all.  So it's not really a problem overall from a
security point of view.

> The issue resides in the function
> print_format2_lock() in fs/dlm/debug_fs.c. When a resource name
> is exactly DLM_RESNAME_MAXLEN bytes long and contains no null
> byte, the %s format specifier in a seq_printf call reads beyond
> the intended buffer, exposing adjacent kernel memory.

That's not good, can you just send a patch for this to the developers
and mailing list and they can apply it like normal?

thanks,

greg k-h
